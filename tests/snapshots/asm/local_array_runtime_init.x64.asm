
local_array_runtime_init.x64:	file format elf64-x86-64

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
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<probe_short>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rax
               	leaq	-0x8(%rbp), %rcx
               	movw	%ax, (%rcx)
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rax
               	leaq	-0x8(%rbp), %rcx
               	movw	%ax, 0x2(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_char>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x62, %eax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, 0x1(%rcx)
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, 0x2(%rcx)
               	movl	$0x64, %eax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, 0x3(%rcx)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0x4, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rdx
               	movslq	%ecx, %rsi
               	addq	%rsi, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0xa(%rax)
               	leaq	<rip>, %rax
               	movl	$0x5678, %ecx           # imm = 0x5678
               	movw	%cx, 0xa(%rax)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x477198, %rax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movzbq	0x5(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
