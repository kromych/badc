
warn_dead_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<dead_initializer>:
               	movl	$0x1, %eax
               	retq

<self_referencing_rhs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %eax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<store_consumed_after_branch_is_silenced>:
               	movslq	%edi, %rdi
               	movl	$0x1, %ecx
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>

<address_escapes_silences>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
