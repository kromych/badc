
struct_value_basics.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	movl	%eax, (%rcx)
               	addq	$0x4, %rcx
               	movl	$0x28, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0xc8, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x172, %rax            # imm = 0x172
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
