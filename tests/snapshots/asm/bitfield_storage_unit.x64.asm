
bitfield_storage_unit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	leaq	-0x10(%rbp), %rax
               	subq	%rax, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x8, %r11
               	leaq	-0x10(%rbp), %rax
               	subq	%rax, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x100, %rax
               	movl	$0xab, %r8d
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	movl	$0x100, %r11d           # imm = 0x100
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	movabsq	$-0xfffffe01, %r10      # imm = 0xFFFFFFFF000001FF
               	andq	%r10, %rax
               	movl	$0x2468a00, %r8d        # imm = 0x2468A00
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	andq	$0xff, %r8
               	cmpq	$0xab, %r8
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x8, %r8
               	andq	$0x1, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x9, %r8
               	andq	$0x7fffff, %r8          # imm = 0x7FFFFF
               	cmpq	$0x12345, %r8           # imm = 0x12345
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x100, %rax
               	movl	$0x55, %r11d
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0xff, %r11
               	cmpq	$0x55, %r11
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x8, %r11
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x9, %r11
               	andq	$0x7fffff, %r11         # imm = 0x7FFFFF
               	cmpq	$0x12345, %r11          # imm = 0x12345
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x100, %rax
               	movl	$0xff, %r8d
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x20(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	movl	$0x100, %r11d           # imm = 0x100
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %r11
               	movl	(%r11), %eax
               	movabsq	$-0xfffffe01, %r10      # imm = 0xFFFFFFFF000001FF
               	andq	%r10, %rax
               	movl	$0xfffffe00, %r8d       # imm = 0xFFFFFE00
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x4, %r8
               	movl	(%r8), %eax
               	andq	$-0x100, %rax
               	xorq	%r11, %r11
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	(%rdi), %eax
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	orq	%r11, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x4, %r8
               	movl	(%r8), %eax
               	movabsq	$-0xfffffe01, %r10      # imm = 0xFFFFFFFF000001FF
               	andq	%r10, %rax
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r11d
               	andq	$0xff, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r11d
               	sarq	$0x8, %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r11d
               	sarq	$0x9, %r11
               	andq	$0x7fffff, %r11         # imm = 0x7FFFFF
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
