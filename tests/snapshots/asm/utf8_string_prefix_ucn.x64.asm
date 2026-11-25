
utf8_string_prefix_ucn.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	nopl	(%rax,%rax)
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rcx
               	andq	$0xff, %rcx
               	movsbq	(%rdi,%rax), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jb	<addr>
               	xorl	%eax, %eax
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
