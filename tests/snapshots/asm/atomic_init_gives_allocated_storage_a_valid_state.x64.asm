
atomic_init_gives_allocated_storage_a_valid_state.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x38, %rsp
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rdx
               	movzwq	(%rdx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rdx), %r10
               	movb	%r10b, 0x2(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movw	$0xffff, (%rcx)         # imm = 0xFFFF
               	movb	$-0x1, 0x2(%rcx)
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%rcx)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rsi
               	movl	$0x3, %edi
               	leaq	0x28(%rsp), %rdx
               	movl	$0x5, %ecx
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movzbq	0x28(%rsp), %rax
               	movzbq	0x2a(%rsp), %rdx
               	movsbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	%dl, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x20(%rsp), %rdx
               	leaq	0x18(%rsp), %rsi
               	movzwq	(%rdx), %r10
               	movw	%r10w, (%rsi)
               	movzbq	0x2(%rdx), %r10
               	movb	%r10b, 0x2(%rsi)
               	movq	%rcx, 0x8(%rsp)
               	movl	$0x3, %edi
               	movl	$0x5, %ecx
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movzbq	0x21(%rsp), %rax
               	movsbq	%al, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	%rcx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
