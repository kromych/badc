
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
               	movslq	%ecx, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq

<multi_decl>:
               	xorq	%rdx, %rdx
               	movl	$0xa, %ecx
               	movq	%rdx, %rax
               	movslq	%edx, %rsi
               	movslq	%ecx, %rdi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	incq	%rdx
               	movslq	%ecx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rsi, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq

<shadowing>:
               	movl	$0x2a, %eax
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x3, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	retq

<adjacent_fors>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0x5, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movl	$0xa, %edx
               	movslq	%edx, %rcx
               	cmpq	$0xd, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	addq	%rdx, %rax
               	jmp	<addr>
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
               	leaq	0xc(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	addq	$0x4, %rcx
               	jmp	<addr>
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rsi
               	jmp	<addr>
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
