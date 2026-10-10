
attributed_aggregate_align_floor.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	<rip>, %rcx      # <addr>
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	xorl	%eax, %eax
               	movq	%rdi, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	cmpl	$0x7, %edi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rdx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	(%rsi), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x31, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x35, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leave
               	retq
