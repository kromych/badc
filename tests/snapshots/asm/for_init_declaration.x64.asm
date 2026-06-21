
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<simple_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<multi_decl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rdx, %rdx
               	movl	$0xa, %ecx
               	movq	%rdx, %rax
               	movslq	%edx, %rsi
               	movslq	%ecx, %rdi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	incq	%rdx
               	movslq	%ecx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	movslq	%edx, %rsi
               	movslq	%ecx, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<shadowing>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x2a, %eax
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x3, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<adjacent_fors>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0x5, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movl	$0xa, %edx
               	movslq	%edx, %rcx
               	cmpq	$0xd, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<struct_ptr_init>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	<rip>, %rax
               	xorq	%rsi, %rsi
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %ecx
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	jmp	<addr>
               	movslq	%esi, %rdx
               	movslq	(%rcx), %rsi
               	addq	%rdx, %rsi
               	jmp	<addr>
               	movslq	%esi, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x32, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2b, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
