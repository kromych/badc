
divmod_preserves_rdx.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x2b0, %esi            # imm = 0x2B0
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x64, %eax
               	movl	$0x32, %ecx
               	movl	$0x19, %edx
               	movl	$0xc, %esi
               	movl	$0x8, %edi
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rdi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movslq	%r11d, %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movslq	%edi, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0xd1, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
