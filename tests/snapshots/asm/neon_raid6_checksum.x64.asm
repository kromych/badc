
neon_raid6_checksum.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	shlq	$0x9, %rdx
               	imulq	$0x43, %r9, %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%rdx), %rdi
               	imulq	$0xd, %rax, %rcx
               	addq	%rsi, %rcx
               	movq	%rax, %r8
               	sarq	$0x3, %r8
               	imulq	$0x7, %r8, %r8
               	addq	%r8, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%r9, %rdx
               	shlq	$0x9, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rsp,%r9,8)
               	incq	%r9
               	cmpl	$0x7, %r9d
               	jl	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	leaq	<rip>, %r8 # <addr>
               	leaq	0x800(%r8), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movl	$0x1d, %esi
               	testb	$-0x80, %cl
               	cmoveq	%rdi, %rsi
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	leaq	0x600(%r8), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	xorq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movl	$0x1d, %r9d
               	testb	$-0x80, %dl
               	cmoveq	%rdi, %r9
               	xorq	%r9, %rsi
               	andq	$0xff, %rsi
               	leaq	0x400(%r8), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	xorq	%rdx, %rsi
               	xorq	%rdx, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	movl	$0x1d, %r8d
               	testb	$-0x80, %sil
               	cmoveq	%rdi, %r8
               	xorq	%r8, %rdx
               	andq	$0xff, %rdx
               	leaq	<rip>, %r8 # <addr>
               	leaq	0x200(%r8), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdx
               	xorq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movl	$0x1d, %r9d
               	xorl	%r10d, %r10d
               	testb	$-0x80, %dl
               	cmoveq	%r10, %r9
               	xorq	%r9, %rsi
               	andq	$0xff, %rsi
               	movzbq	(%r8,%rax), %rdx
               	xorq	%rdx, %rsi
               	xorq	%rdx, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movb	%cl, (%rdx,%rax)
               	leaq	<rip>, %rcx # <addr>
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	xorl	%ecx, %ecx
               	movzbq	(%rdi,%rcx), %rdx
               	xorq	%rax, %rdx
               	movabsq	$0x100000001b3, %rax    # imm = 0x100000001B3
               	imulq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x200, %ecx            # imm = 0x200
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movzbq	(%rsi,%rcx), %rdx
               	xorq	%rdx, %rax
               	movabsq	$0x100000001b3, %r11    # imm = 0x100000001B3
               	imulq	%r11, %rax
               	incq	%rcx
               	cmpl	$0x200, %ecx            # imm = 0x200
               	jl	<addr>
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	addq	$0x48, %rsp
               	retq
