
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
               	subq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x9, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x43, %rcx, %rsi
               	imulq	$0xd, %rax, %rdi
               	addq	%rdi, %rsi
               	movq	%rax, %rdi
               	sarq	$0x3, %rdi
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x9, %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, (%rax,%rcx,8)
               	incq	%rcx
               	cmpl	$0x7, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	<rip>, %rsi # <addr>
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
               	leaq	<rip>, %rsi # <addr>
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
               	xorq	%rdx, %r8
               	movq	%rsi, %rdi
               	shlq	%rdi
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
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
