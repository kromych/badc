
mem2reg_i64_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	movl	$0x3, %r10d
               	imulq	%r10, %r11
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	movq	%r9, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	movq	-0x10(%rbp), %r8
               	addq	%r11, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movq	%r9, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
