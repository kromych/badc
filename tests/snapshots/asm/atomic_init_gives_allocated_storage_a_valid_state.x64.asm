
atomic_init_gives_allocated_storage_a_valid_state.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	testq	%r8, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movw	$0xffff, (%r8)          # imm = 0xFFFF
               	movb	$-0x1, 0x2(%r8)
               	movzwq	(%rax), %r10
               	movw	%r10w, (%r8)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%r8)
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x3, %edi
               	movl	$0x5, %ecx
               	movq	%r8, 0x8(%rsp)
               	movq	%r8, %rsi
               	callq	<addr>
               	movq	0x8(%rsp), %r8
               	movzbq	-0x10(%rbp), %rax
               	movzbq	-0xe(%rbp), %rcx
               	movsbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	%cl, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rsi
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rsi)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x3, %edi
               	movl	$0x5, %ecx
               	movq	%r8, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %r8
               	movzbq	-0x7(%rbp), %rax
               	movsbq	%al, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%r8, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
