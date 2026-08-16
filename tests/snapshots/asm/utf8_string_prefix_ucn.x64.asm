
utf8_string_prefix_ucn.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x2, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x3, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x5, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x5, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x5, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x2, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x4, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
