
pointer_to_array_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x270, %esi            # imm = 0x270
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
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x18, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	movslq	%esi, %rsi
               	movswq	%si, %rsi
               	movw	%si, (%rax,%rdx,2)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movswq	0xc(%rax), %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
