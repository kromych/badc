
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

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
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<preinc_u8_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xff, %eax
               	xorq	%rdx, %rdx
               	incq	%rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u16_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	xorq	%rdx, %rdx
               	incq	%rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u32_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorq	%rdx, %rdx
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<compound_u8_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xf0, %eax
               	xorq	%rdx, %rdx
               	addq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<compound_u16_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xfff0, %eax           # imm = 0xFFF0
               	xorq	%rdx, %rdx
               	addq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u8_through_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rdx, %rdx
               	movzbq	(%rax), %rcx
               	incq	%rcx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movzbq	-0x8(%rbp), %rax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
