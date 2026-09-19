
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	movl	%ecx, %eax
               	cmpl	$0x2, %eax
               	jae	<addr>
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
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	xorq	%rcx, %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movsbq	(%rsi,%rax), %r8
               	andq	$0xff, %r8
               	movsbq	(%rdi,%rax), %r9
               	andq	$0xff, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	movl	%ecx, %eax
               	cmpl	$0x3, %eax
               	jae	<addr>
               	movsbq	(%rsi,%rax), %rdi
               	andq	$0xff, %rdi
               	movsbq	(%rdx,%rax), %r8
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
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
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
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
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
               	movl	%ecx, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
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
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
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
               	movl	%ecx, %eax
               	cmpl	$0x2, %eax
               	jae	<addr>
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
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
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
