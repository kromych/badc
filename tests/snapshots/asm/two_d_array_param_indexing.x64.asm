
two_d_array_param_indexing.x64:	file format elf64-x86-64

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
               	subq	$0x400, %rsp            # imm = 0x400
               	xorl	%eax, %eax
               	leaq	-0x400(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x0, (%rcx)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	movl	$0x101234, -0x3ec(%rbp) # imm = 0x101234
               	movzwq	-0x3ec(%rbp), %rax
               	movzwq	-0x3ea(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x1244, %eax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x78(%rbp), %rcx
               	imulq	$0xc, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, 0x4(%rcx)
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movl	-0x24(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x1c(%rbp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x837, %eax            # imm = 0x837
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	leaq	0x41(%rax), %rcx
               	movb	%cl, (%rdx,%rsi)
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movb	%sil, 0x1(%rdx)
               	addq	$0x2, %rcx
               	movb	%cl, 0x2(%rdx)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	0x41(%rax), %rdx
               	addq	$0x3, %rdx
               	movb	%dl, 0x3(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsbq	-0x14(%rbp), %rax
               	movsbq	-0x13(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x12(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x11(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x116, %eax            # imm = 0x116
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
