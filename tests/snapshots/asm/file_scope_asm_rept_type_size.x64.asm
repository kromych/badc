
file_scope_asm_rept_type_size.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax        # <addr>
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x1(%rax), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x2(%rax), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x3(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x4(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x5(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x6(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq

<rept_run>:
               	addb	$0x4, %al
               	addb	$0x7, %al
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>

<rept_run_len>:
               	orb	%al, (%rax)
               	addb	%al, (%rax)
