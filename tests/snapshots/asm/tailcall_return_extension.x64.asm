
tailcall_return_extension.x64:	file format elf64-x86-64

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

<load_le32>:
               	cmpl	$0x4, %esi
               	jge	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shlxq	%rcx, %rax, %r10
               	movq	%r10, 0x8(%rsp)
               	incq	%rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	orq	%r10, %rax
               	leave
               	retq
               	xorl	%eax, %eax
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
