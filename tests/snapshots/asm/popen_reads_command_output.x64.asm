
popen_reads_command_output.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x40, %esi
               	movq	%r8, 0x8(%rsp)
               	movq	%r8, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %r8
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movq	%r8, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %r8
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rcx
               	decq	%rax
               	movb	$0x0, (%rcx,%rax)
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x1(%rax), %rdx
               	movsbq	(%rcx,%rdx), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	cmpl	$0xd, %ecx
               	je	<addr>
               	cmpl	$0x20, %ecx
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movq	%r8, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %r8
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%r8, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
