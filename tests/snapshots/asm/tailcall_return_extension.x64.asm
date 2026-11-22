
tailcall_return_extension.x64:	file format elf64-x86-64

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

<load_le32>:
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	cmpl	$0x4, %esi
               	jge	<addr>
               	movzbq	(%rdi,%rsi), %rcx
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	incq	%rsi
               	orq	%rcx, %rax
               	cmpl	$0x4, %esi
               	jl	<addr>
               	retq

<get_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	callq	<addr>
               	popq	%rbp
               	retq

<widen>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%esi, %esi
               	callq	<addr>
               	movl	%eax, %eax
               	popq	%rbp
               	retq

<load_alias>:
               	xorl	%esi, %esi
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movl	$0xfebf1000, -0x8(%rbp) # imm = 0xFEBF1000
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0xfebf1000, %eax       # imm = 0xFEBF1000
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0xfebf1000, %eax       # imm = 0xFEBF1000
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x7f, -0x5(%rbp)
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x7fbf1000, %eax       # imm = 0x7FBF1000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
