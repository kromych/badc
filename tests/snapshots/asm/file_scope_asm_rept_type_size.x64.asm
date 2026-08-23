
file_scope_asm_rept_type_size.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi        # <addr>
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x4, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	$0x3, %eax
               	leaq	<rip>, %rsi        # <addr>
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x7, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq

<rept_run>:
               	addb	$0x4, %al
               	addb	$0x7, %al
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>

<rept_run_len>:
               	orb	%al, (%rax)
               	addb	%al, (%rax)
