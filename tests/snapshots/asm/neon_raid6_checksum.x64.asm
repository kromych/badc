
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

<scalar_syndrome>:
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	<rip>, %rsi
               	leaq	0x800(%rsi), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	testb	$-0x80, %dl
               	je	<addr>
               	movl	$0x1d, %edi
               	xorq	%r8, %rdi
               	andq	$0xff, %rdi
               	addq	$0x600, %rsi            # imm = 0x600
               	movzbq	(%rsi,%rax), %rsi
               	xorq	%rsi, %rdi
               	movq	%rdx, %r8
               	xorq	%rsi, %r8
               	movq	%rdi, %rsi
               	shlq	%rsi
               	testb	$-0x80, %dil
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%rsi, %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x400(%rsi), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %r8
               	movq	%rdi, %r9
               	shlq	%r9
               	testb	$-0x80, %dil
               	je	<addr>
               	movl	$0x1d, %edx
               	xorq	%r9, %rdx
               	movq	%rdx, %rdi
               	andq	$0xff, %rdi
               	leaq	0x200(%rsi), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movq	%rdi, %rsi
               	xorq	%rdx, %rsi
               	movq	%r8, %rdi
               	xorq	%rdx, %rdi
               	movq	%rsi, %r8
               	shlq	%r8
               	testb	$-0x80, %sil
               	je	<addr>
               	movl	$0x1d, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
               	xorq	%r8, %rdx
               	movq	%rdx, %rsi
               	andq	$0xff, %rsi
               	leaq	<rip>, %rdx
               	movzbq	(%rdx,%rax), %rdx
               	xorq	%rdx, %rsi
               	xorq	%rdi, %rdx
               	leaq	<rip>, %rdi
               	movb	%dl, (%rdi,%rax)
               	leaq	<rip>, %rdx
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rcx, %rsi
               	shlq	$0x9, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x43, %rcx, %rdi
               	imulq	$0xd, %rax, %r8
               	addq	%r8, %rdi
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
               	movq	%rcx, %rsi
               	shlq	$0x9, %rsi
               	addq	%rdx, %rsi
               	movq	%rsi, (%rax,%rcx,8)
               	incq	%rcx
               	cmpl	$0x7, %ecx
               	jl	<addr>
               	callq	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movabsq	$0x100000001b3, %rdi    # imm = 0x100000001B3
               	xorl	%ecx, %ecx
               	movzbq	(%rsi,%rcx), %r8
               	xorq	%r8, %rax
               	imulq	%rdi, %rax
               	incq	%rcx
               	cmpl	$0x200, %ecx            # imm = 0x200
               	jl	<addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%ecx, %ecx
               	movzbq	(%rdx,%rcx), %rdi
               	xorq	%rdi, %rax
               	imulq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x200, %ecx            # imm = 0x200
               	jl	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
