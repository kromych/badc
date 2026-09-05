
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
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x5, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x5, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x5, %ecx
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	andq	$0xff, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movsbq	(%r8), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x4, %ecx
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
               	movl	$0x18, %eax
               	retq
               	movl	$0x16, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x5, %eax
               	retq
