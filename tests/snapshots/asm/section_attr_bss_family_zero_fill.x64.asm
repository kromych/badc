
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
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
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
               	xorl	%eax, %eax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jge	<addr>
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	jge	<addr>
               	movslq	%eax, %rsi
               	movsbq	(%rdx,%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rax), %rax
               	addq	%rdx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x9, %eax
               	movq	%rax, (%rcx)
               	movl	$0x1, %eax
               	movq	%rax, 0xff8(%rcx)
               	leaq	<rip>, %rax
               	addq	$0x3fff, %rax           # imm = 0x3FFF
               	movl	$0x7, %edx
               	movb	%dl, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x5, %esi
               	movq	%rsi, 0x38(%rdx)
               	movq	(%rcx), %rdx
               	movq	0xff8(%rcx), %rcx
               	addq	%rdx, %rcx
               	movsbq	(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x5, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x4, %eax
               	retq
