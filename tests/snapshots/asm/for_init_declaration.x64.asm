
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<simple_sum>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	addq	%rcx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<multi_decl>:
               	xorq	%rdx, %rdx
               	movl	$0xa, %ecx
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rsi, %rax
               	incq	%rdx
               	movslq	%ecx, %rcx
               	decq	%rcx
               	movslq	%edx, %rsi
               	movslq	%ecx, %rdi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<shadowing>:
               	movl	$0x2a, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	retq
               	jmp	<addr>

<adjacent_fors>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	addq	%rcx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	movl	$0xa, %edx
               	jmp	<addr>
               	addq	%rdx, %rax
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0xd, %rcx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<struct_ptr_init>:
               	leaq	<rip>, %rax
               	xorq	%rsi, %rsi
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %ecx
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rsi
               	addq	$0x4, %rcx
               	leaq	0xc(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	movslq	%esi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
