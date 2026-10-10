
cacheline_aligned_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movq	%rax, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x44(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x44, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	%rax, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x80(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	leaq	0x40(%rax), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpl	$0x40, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	0xc0(%rax), %rdx
               	subq	%rax, %rdx
               	cmpl	$0xc0, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	andq	$0x3f, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	leaq	0x40(%rdx), %rsi
               	testb	$0x3f, %sil
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movq	%rcx, %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	leaq	0x80(%rax), %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0xc0(%rax), %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0xb, (%rcx)
               	movl	$0x21, 0xc0(%rax)
               	movl	$0x2c, 0x40(%rdx)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x37, (%rax)
               	movl	(%rcx), %ecx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	0xc0(%rcx), %ecx
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x40(%rcx), %ecx
               	cmpl	$0x2c, %ecx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x37, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
