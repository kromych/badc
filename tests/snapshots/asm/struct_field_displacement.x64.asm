
struct_field_displacement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	0x4(%rdi), %rax
               	retq
               	movq	0x8(%rdi), %rax
               	retq
               	movswq	0x10(%rdi), %rax
               	retq
               	movzbq	0x12(%rdi), %rax
               	retq
               	movslq	%esi, %rsi
               	movl	%esi, 0x4(%rdi)
               	xorq	%rax, %rax
               	retq
               	movq	%rsi, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x16, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x14d, %ecx            # imm = 0x14D
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2c, %ecx
               	movw	%cx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x12(%rax)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x63, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x309, %esi            # imm = 0x309
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x309, %rax            # imm = 0x309
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movswq	0x10(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzbq	0x12(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
