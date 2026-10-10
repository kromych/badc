
call_arg_param_home.x64:	file format elf64-x86-64

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

<take>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	0x10(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x11(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x12(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x13(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	leaq	<rip>, %rax      # <addr>
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	%esi, (%rax)
               	leave
               	retq

<pass>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r9
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r9
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
