
unary_minus_uint64_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0xa8, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa8, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
