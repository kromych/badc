
section_attr_bss_family_zero_fill.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	movq	%rdx, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rsi,%rcx,8), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x9, %eax
               	movq	%rax, (%rdx)
               	movl	$0x1, %eax
               	movq	%rax, 0xff8(%rdx)
               	leaq	<rip>, %rax
               	leaq	0x3fff(%rax), %rcx
               	movl	$0x7, %eax
               	movb	%al, (%rcx)
               	leaq	<rip>, %rax
               	movl	$0x5, %esi
               	movq	%rsi, 0x38(%rax)
               	movq	(%rdx), %rdi
               	movq	0xff8(%rdx), %rdx
               	addq	%rdi, %rdx
               	movsbq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	leaq	(%rcx,%rsi), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x4, %eax
               	retq
