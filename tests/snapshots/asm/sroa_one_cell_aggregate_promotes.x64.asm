
sroa_one_cell_aggregate_promotes.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movq	<rip>, %rdx # <addr>
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	movl	%eax, %r8d
               	addq	%r8, %rsi
               	leaq	(%rax,%rdx), %r8
               	movl	$0x2, %r9d
               	cmpl	$0x2, %ecx
               	cmovbq	%r8, %rax
               	movq	%rdi, %rcx
               	cmovbq	%r9, %rcx
               	nopl	(%rax,%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movsbq	%dl, %r10
               	movq	%r10, %rcx
               	xorq	$0x61, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	leaq	(%rsi,%rax), %rcx
               	movswq	%dx, %r11
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movswq	%si, %rsi
               	leaq	-0x3(%rdx), %rdi
               	movswq	%di, %rdi
               	shlq	%rax
               	addq	%r11, %rax
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	leaq	(%rcx,%rax), %r9
               	movq	%r9, 0x8(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	movl	%eax, %r8d
               	addq	%r8, %rsi
               	leaq	(%rax,%rdx), %r8
               	movl	$0x2, %r9d
               	cmpl	$0x2, %ecx
               	cmovbq	%r8, %rax
               	movq	%rdi, %rcx
               	cmovbq	%r9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%r10, %rcx
               	xorq	$0x61, %rcx
               	movq	%rax, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x83, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	subq	$0x3, %rdx
               	movswq	%dx, %rdx
               	shlq	%rax
               	addq	%r11, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x16a, %rax            # imm = 0x16A
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
