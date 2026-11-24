
fscanf_reads_whole_fields_across_threads.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rdx
               	movq	0x18(%rsp), %rcx
               	movl	$0x1, %esi
               	cmpq	$0x19640, %rcx          # imm = 0x19640
               	setge	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x186a0, %rcx          # imm = 0x186A0
               	cmovgeq	%rdi, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movq	%rcx, (%rax,%rbx,8)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %rcx
               	movq	0x18(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax,%rbx,8)
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %rdx
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
               	addq	$0x20, %rsp
               	retq

<race>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movl	%r12d, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%ebx, %ebx
               	testl	%r12d, %r12d
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	0x186a0(%rbx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	jmp	<addr>
               	movq	<rip>, %rdi # <addr>
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
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	leaq	0x10(%rsp), %rdi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %ecx
               	leaq	0x10(%rsp), %rax
               	leaq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpq	$0x18518e30, %rax       # imm = 0x18518E30
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0xa8, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	addq	$0xa8, %rsp
               	retq
               	xorl	%ebx, %ebx
               	callq	<addr>
               	movq	%rax, 0x10(%rsp,%rbx,8)
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
               	addq	$0xa8, %rsp
               	retq
               	xorl	%ebx, %ebx
               	movq	0x10(%rsp,%rbx,8), %rdi
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0xa8, %rsp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0xa8, %rsp
               	retq
