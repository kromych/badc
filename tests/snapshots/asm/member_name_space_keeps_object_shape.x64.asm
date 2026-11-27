
member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rdx,%rdi), %rsi
               	leaq	0x1(%rax), %r8
               	movl	%eax, (%rsi)
               	leaq	0x1(%r8), %rax
               	movl	%r8d, 0x4(%rsi)
               	leaq	0x1(%rax), %r8
               	movl	%eax, 0x8(%rsi)
               	leaq	(%rdx,%rdi), %rax
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0xc(%rax)
               	leaq	0x1(%rsi), %rdi
               	movl	%esi, 0x10(%rax)
               	leaq	0x1(%rdi), %rsi
               	movl	%edi, 0x14(%rax)
               	imulq	$0x30, %rcx, %rdi
               	leaq	(%rdx,%rdi), %rax
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x18(%rax)
               	leaq	0x1(%r8), %rsi
               	movl	%r8d, 0x1c(%rax)
               	leaq	0x1(%rsi), %r8
               	movl	%esi, 0x20(%rax)
               	leaq	(%rdx,%rdi), %rsi
               	leaq	0x1(%r8), %rax
               	movl	%r8d, 0x24(%rsi)
               	leaq	0x1(%rax), %rdi
               	movl	%eax, 0x28(%rsi)
               	leaq	0x1(%rdi), %rax
               	movl	%edi, 0x2c(%rsi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x300000002, %rcx      # imm = 0x300000002
               	movl	$0x3, %eax
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0xb0000000a, %rcx      # imm = 0xB0000000A
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0xd0000000c, %rcx      # imm = 0xD0000000C
               	movq	%rcx, <rip> # <addr>
               	movl	$0x14, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x15, <rip> # <addr>
               	movabsq	$0x1700000016, %rdx     # imm = 0x1700000016
               	movq	%rdx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x1, %edx
               	je	<addr>
               	retq
               	leaq	0x10(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
