
asm_pcrel_words_name_text_and_data.x64:	file format elf64-x86-64

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

<fn>:
               	movl	$0x3, %eax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movslq	(%rax), %rcx
               	leaq	-<rip>, %rdx # <addr>
               	addq	%rax, %rcx
               	subq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rcx
               	addq	%rax, %rcx
               	subq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x4, %rax
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x3, %rax
               	xorl	%ecx, %ecx
               	movl	$0x9, %edx
               	cmpl	$0x7, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
               	leaq	0x4(%rax), %rcx
               	movslq	0x4(%rax), %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rsi, %rcx
               	subq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x8(%rax), %rcx
               	movslq	0x8(%rax), %rsi
               	leaq	0x18(%rax), %rdi
               	addq	%rsi, %rcx
               	subq	%rdi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	addq	$0x10, %rax
               	movq	(%rax), %rcx
               	addq	%rcx, %rax
               	subq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x4(%rax), %rcx
               	movslq	0x4(%rax), %rdi
               	addq	%rdi, %rcx
               	subq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x8(%rax), %rcx
               	movslq	0x8(%rax), %rdi
               	leaq	0x18(%rax), %r8
               	addq	%rdi, %rcx
               	subq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	addq	$0x10, %rax
               	movq	(%rax), %rcx
               	addq	%rcx, %rax
               	subq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<text_tbl>:
               	testb	$-0x2, %al
               	<unknown>
               	lock
               	subl	%eax, (%rax)
               	addb	%dl, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%ah, %ah
               	subl	%eax, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)

<text_end>:
               	addb	%al, (%rax)
               	addb	%al, (%rax)
