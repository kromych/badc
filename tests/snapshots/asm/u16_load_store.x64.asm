
u16_load_store.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	$0x4241, %ecx           # imm = 0x4241
               	movw	%cx, 0x2(%rax)
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x41, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x42, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x4(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	incq	%rax
               	movzwq	(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x4342, %rax           # imm = 0x4342
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
