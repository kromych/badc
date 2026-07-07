
bitfield_mixed_base_packing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	orq	$0x80, %rcx
               	movb	%cl, 0x3(%rax)
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
               	movl	$0xdeadbeef, %ecx       # imm = 0xDEADBEEF
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x3(%rax), %rax
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
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rax), %rax
               	sarq	$0x6, %rax
               	andq	$0x3, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x8(%rax), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	(%rax), %edx
               	andq	$-0x80000000, %rdx      # imm = 0x80000000
               	orq	%rcx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rax), %rdx
               	andq	$-0xc1, %rdx
               	orq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	0x8(%rax), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x200, %rcx           # imm = 0xFE00
               	orq	$0x1ff, %rcx            # imm = 0x1FF
               	movw	%cx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x2(%rax), %rcx
               	andq	$-0x200, %rcx           # imm = 0xFE00
               	orq	$0x123, %rcx            # imm = 0x123
               	movw	%cx, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpq	$0x1ff, %rax            # imm = 0x1FF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x2(%rax), %rax
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
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
