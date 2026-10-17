
string_literal_initializes_every_character_array.x64:	file format elf64-x86-64

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

<literals>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	0x10(%rax), %r10
               	movb	%r10b, 0x10(%rdi)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	0x10(%rcx), %r10
               	movb	%r10b, 0x10(%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %r10
               	movb	%r10b, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	-0x5e(%rbp), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movsbq	-0x56(%rbp), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movsbq	-0x50(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	-0x47(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movsbq	-0x3b(%rbp), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq

<members>:
               	leaq	<rip>, %rax      # <addr>
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x71, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x71, %edi
               	callq	<addr>
               	jmp	<addr>
