
builtin_library_alias_macro_shadow.x64:	file format elf64-x86-64

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

<__fortify_strlen>:
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rdi,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	retq

<main>:
               	pushq	%rax
               	leaq	<rip>, %rcx # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x65, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x6c, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x6c, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%r11
               	retq
               	movb	$0x0, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%r11
               	retq
               	movb	$0x0, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%r11
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1c, %eax
               	popq	%r11
               	retq
               	movb	$0x61, (%rdi)
               	movl	$0x10, %esi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rdi), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	movl	$0x2, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
