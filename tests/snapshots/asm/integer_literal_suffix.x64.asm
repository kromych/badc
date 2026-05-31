
integer_literal_suffix.x64:	file format elf64-x86-64

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
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%r11, %r9
               	subq	$0x1, %r9
               	movabsq	$0xfffffffff, %r10      # imm = 0xFFFFFFFFF
               	movq	%r9, %r11
               	cmpq	%r10, %r9
               	je	0x40027a <.text+0x5a>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %r11d
               	movl	$0x1, %eax
               	movslq	%r11d, %r8
               	movq	%rax, %r11
               	movq	%r8, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %r8
               	subq	$0x1, %r8
               	movabsq	$0xfffffffff, %r10      # imm = 0xFFFFFFFFF
               	movq	%r8, %r11
               	cmpq	%r10, %r8
               	je	0x4002bf <.text+0x9f>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movabsq	$0x12345678a, %r10      # imm = 0x12345678A
               	movq	%rax, %r11
               	cmpq	%r10, %rax
               	je	0x4002f7 <.text+0xd7>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r11
               	cmpq	$-0x1, %r11
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x40(%rbp)
               	cmpq	$0x0, %rax
               	je	0x40033e <.text+0x11e>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r11, %r8
               	cmpq	%r10, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x40(%rbp)
               	jmp	0x40033e <.text+0x11e>
               	movq	-0x40(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x40035d <.text+0x13d>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %r11
               	je	0x400378 <.text+0x158>
               	movl	$0xf, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x4003a7 <.text+0x187>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
