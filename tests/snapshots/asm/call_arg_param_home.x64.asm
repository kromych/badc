
call_arg_param_home.x64:	file format elf64-x86-64

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

<take>:
               	subq	$0x18, %rsp
               	movl	0x20(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	movl	%edi, <rip> # <addr>
               	movl	%esi, <rip> # <addr>
               	addq	$0x18, %rsp
               	retq

<pass>:
               	pushq	%rax
               	subq	$0x10, %rsp
               	movq	%rdi, %r9
               	movl	$0x1, %edi
               	movl	$0x2, %esi
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
               	popq	%r11
               	retq

<main>:
               	subq	$0x18, %rsp
               	subq	$0x10, %rsp
               	leaq	0x18(%rsp), %r9
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
