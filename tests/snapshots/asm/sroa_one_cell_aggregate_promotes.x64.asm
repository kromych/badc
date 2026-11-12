
sroa_one_cell_aggregate_promotes.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	<rip>, %rsi # <addr>
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rdx
               	movl	%eax, %r8d
               	addq	%r8, %rdx
               	leaq	(%rax,%rsi), %r8
               	movl	$0x2, %r9d
               	cmpl	$0x2, %ecx
               	cmovbq	%r8, %rax
               	movq	%rdi, %rcx
               	cmovbq	%r9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x7(%rsi), %rax
               	movswq	%ax, %rax
               	movsbq	%sil, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movswq	%si, %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	0x1(%rsi), %rcx
               	movswq	%cx, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	movswq	%dx, %rdx
               	leaq	-0x3(%rsi), %rdi
               	movswq	%di, %rdi
               	shlq	%rcx
               	movq	%rcx, %r10
               	movq	0x10(%rsp), %rcx
               	addq	%r10, %rcx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x8(%rsp)
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movl	%eax, %edi
               	addq	%rdi, %rdx
               	leaq	(%rax,%rsi), %rdi
               	movl	$0x2, %r8d
               	xorl	%r9d, %r9d
               	cmpl	$0x2, %ecx
               	cmovbq	%rdi, %rax
               	movq	%r9, %rcx
               	cmovbq	%r8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	0x7(%rsi), %rax
               	movswq	%ax, %rax
               	movq	0x18(%rsp), %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x83, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	0x1(%rsi), %rax
               	movswq	%ax, %rax
               	movq	%rsi, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	leaq	-0x3(%rsi), %rdx
               	movswq	%dx, %rdx
               	shlq	%rax
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	addq	%r10, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x16a, %rax            # imm = 0x16A
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
