
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
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movzbq	0x4(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
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
               	addb	%al, (%rax)

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
