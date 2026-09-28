
unsigned_compound_assign.x64:	file format elf64-x86-64

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

<rtu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<rtul>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x3e8, -0x8(%rbp)      # imm = 0x3E8
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movl	$0x64, %edi
               	callq	<addr>
               	leaq	0x5(%rax), %rsi
               	movq	%rsi, %rax
               	xorq	$0x69, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	leaq	0x19f(%rax), %rsi
               	cmpq	$0x587, %rsi            # imm = 0x587
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x41c, %edi            # imm = 0x41C
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x502, %edi            # imm = 0x502
               	callq	<addr>
               	subq	$0x363, %rax            # imm = 0x363
               	leaq	(%rbx,%rax), %rsi
               	movq	%rsi, %rax
               	xorq	$0x5bb, %rax            # imm = 0x5BB
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc8, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	addq	$0x3c, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xa, 0x4(%rax)
               	movl	$0x14, 0x8(%rax)
               	movl	$0x1e, 0xc(%rax)
               	movl	$0x28, 0x10(%rax)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movslq	0xc(%rax), %rdx
               	cmpl	$0x1e, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	0xc(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
