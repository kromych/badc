
bitfield_mixed_base_packing.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x80000000, %rcx      # imm = 0x80000000
               	orq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x3(%rax), %rcx
               	andq	$-0x81, %rcx
               	movq	%rcx, %rdx
               	orq	$0x80, %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rax), %rcx
               	andq	$-0xc1, %rcx
               	orq	$0xc0, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xab, %esi
               	movb	%sil, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	sarq	$0x7, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	cmpq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	sarq	$0x6, %rax
               	andq	$0x3, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	(%rax), %esi
               	andq	$-0x80000000, %rsi      # imm = 0x80000000
               	orq	%rdx, %rsi
               	movl	%esi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	andq	$0xff, %rcx
               	andq	$-0xc1, %rcx
               	orq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x200, %rcx           # imm = 0xFE00
               	orq	$0x1ff, %rcx            # imm = 0x1FF
               	movw	%cx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x2(%rax), %rdx
               	andq	$-0x200, %rdx           # imm = 0xFE00
               	orq	$0x123, %rdx            # imm = 0x123
               	movw	%dx, 0x2(%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpq	$0x1ff, %rax            # imm = 0x1FF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpq	$0x123, %rax            # imm = 0x123
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
