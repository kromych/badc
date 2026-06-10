
long_long_distinct.x64:	file format elf64-x86-64

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
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$0x123456789abcdef, %r13 # imm = 0x123456789ABCDEF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movl	$0xc8, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0xa, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x14, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1e, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x60(%rbp), %rax
               	movl	$0xc8, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	cmpq	$0xc8, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
