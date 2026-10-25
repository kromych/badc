
fscanf_reads_whole_fields_across_threads.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<reader>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx,%rbx,8), %rdx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	movl	$0x1, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x19640, %rax          # imm = 0x19640
               	setge	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx,%rbx,8)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax,%rbx,8)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<race>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %r12
               	leaq	<rip>, %rax # <addr>
               	movl	%r12d, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	$0x0, 0x8(%rdx)
               	movq	$0x0, (%rdx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, (%rcx)
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, (%rcx)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x186a0(%rbx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x186a0(%rbx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0xfa0, %ebx            # imm = 0xFA0
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	leaq	-0x10(%rbp), %rdi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %ecx
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x18518e30, %rax       # imm = 0x18518E30
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	-0xa0(%rbp), %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12,%rbx,8)
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xa, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
