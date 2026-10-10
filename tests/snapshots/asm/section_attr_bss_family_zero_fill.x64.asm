
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
               	leaq	<rip>, %rcx      # <addr>
               	testl	$0xfff, %ecx            # imm = 0xFFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	testl	$0xfff, %edx            # imm = 0xFFF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	testl	$0xfff, %eax            # imm = 0xFFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	cmpq	$0x0, (%rcx,%rax,8)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x20(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x28(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x30(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x38(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x9, (%rax)
               	movq	$0x1, 0xff8(%rax)
               	leaq	<rip>, %rcx      # <addr>
               	addq	$0x3fff, %rcx           # imm = 0x3FFF
               	movb	$0x7, (%rcx)
               	leaq	<rip>, %rdx      # <addr>
               	movq	$0x5, 0x38(%rdx)
               	movq	(%rax), %rdx
               	movq	0xff8(%rax), %rax
               	addq	%rdx, %rax
               	movsbq	(%rcx), %rcx
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
