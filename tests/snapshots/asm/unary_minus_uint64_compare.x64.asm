
unary_minus_uint64_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0xa8, %r11d
               	movabsq	$-0x1, %r9
               	imulq	%r11, %r9
               	cmpq	$0x1000, %r9            # imm = 0x1000
               	jae	0x400271 <.text+0x51>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	leaq	0xfe54(%rip), %rax      # 0x4100d0
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	popq	%rcx
               	movq	%r11, %r8
               	leaq	-0x10(%rbp), %r8
               	movq	(%r8), %rax
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r8
               	imulq	%rax, %r8
               	cmpq	$0x1000, %r8            # imm = 0x1000
               	jae	0x4002be <.text+0x9e>
               	movl	$0xc, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa8, %eax
               	movabsq	$-0x1, %r8
               	imulq	%rax, %r8
               	cmpq	$0x1000, %r8            # imm = 0x1000
               	jae	0x4002ed <.text+0xcd>
               	movl	$0x1, %r8d
               	movq	%r8, -0x38(%rbp)
               	jmp	0x4002fc <.text+0xdc>
               	movl	$0x2, %r8d
               	movq	%r8, -0x38(%rbp)
               	jmp	0x4002fc <.text+0xdc>
               	movq	-0x38(%rbp), %r8
               	movslq	%r8d, %rax
               	cmpq	$0x2, %rax
               	je	0x40031e <.text+0xfe>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %r8d
               	movabsq	$-0x1, %rax
               	imulq	%r8, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	0x40034d <.text+0x12d>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
