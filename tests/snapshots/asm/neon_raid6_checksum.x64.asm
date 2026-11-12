
neon_raid6_checksum.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	movq	%r9, %rcx
               	shlq	$0x9, %rcx
               	imulq	$0x43, %r9, %rdx
               	leaq	<rip>, %rsi # <addr>
               	addq	%rcx, %rsi
               	imulq	$0xd, %rax, %rdi
               	addq	%rdx, %rdi
               	movq	%rax, %r8
               	sarq	$0x3, %r8
               	imulq	$0x7, %r8, %r8
               	addq	%r8, %rdi
               	incq	%rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	%r9, %rdx
               	shlq	$0x9, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax,%r9,8)
               	incq	%r9
               	cmpl	$0x7, %r9d
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x800(%rsi), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	movl	$0x1d, %r8d
               	testb	$-0x80, %dl
               	cmoveq	%rcx, %r8
               	xorq	%r8, %rdi
               	andq	$0xff, %rdi
               	addq	$0x600, %rsi            # imm = 0x600
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdi
               	movq	%rdx, %r8
               	xorq	%rsi, %r8
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movl	$0x1d, %esi
               	testb	$-0x80, %dil
               	cmoveq	%rcx, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x400(%rdx), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdi
               	xorq	%rsi, %r8
               	movq	%rdi, %rsi
               	shlq	%rsi
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %dil
               	cmoveq	%rbx, %r9
               	xorq	%r9, %rsi
               	andq	$0xff, %rsi
               	addq	$0x200, %rdx            # imm = 0x200
               	movzbq	(%rdx,%rax), %rdx
               	xorq	%rdx, %rsi
               	xorq	%rdx, %r8
               	movq	%rsi, %rdx
               	shlq	%rdx
               	movl	$0x1d, %edi
               	xorl	%r9d, %r9d
               	testb	$-0x80, %sil
               	cmoveq	%r9, %rdi
               	xorq	%rdi, %rdx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	leaq	<rip>, %rdx # <addr>
               	movzbq	(%rdx,%rax), %rdx
               	xorq	%rdx, %rsi
               	xorq	%r8, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	%dl, (%rdi,%rax)
               	leaq	<rip>, %rdx # <addr>
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	xorl	%ecx, %ecx
               	movzbq	(%rsi,%rcx), %rdi
               	xorq	%rax, %rdi
               	movabsq	$0x100000001b3, %rax    # imm = 0x100000001B3
               	imulq	%rdi, %rax
               	incq	%rcx
               	cmpl	$0x200, %ecx            # imm = 0x200
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movzbq	(%rdx,%rcx), %rsi
               	xorq	%rsi, %rax
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
               	popq	%rbx
               	leave
               	retq
