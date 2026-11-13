
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	0x10(%rax), %r10
               	movb	%r10b, 0x10(%rdi)
               	leaq	-0x28(%rbp), %rax
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
               	movzbq	(%rcx), %r10
               	movb	%r10b, (%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x48(%rbp), %rax
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
               	leaq	-0x28(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0x6200000061, %rax     # imm = 0x6200000061
               	movq	%rax, -0x40(%rbp)
               	movabsq	$0x7100000000, %rax     # imm = 0x7100000000
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	movl	$0x71006261, -0x28(%rbp) # imm = 0x71006261
               	movl	-0x3c(%rbp), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x71, %eax
               	jne	<addr>
               	movsbq	-0x27(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movsbq	-0x5e(%rbp), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movsbq	-0x58(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	-0x4f(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movsbq	-0x43(%rbp), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
