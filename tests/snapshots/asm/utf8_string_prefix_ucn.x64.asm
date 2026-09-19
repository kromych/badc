
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movq	%rcx, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
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
