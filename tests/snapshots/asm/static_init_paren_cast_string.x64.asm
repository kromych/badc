
static_init_paren_cast_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfeea(%rip), %r11      # 0x410128
               	movq	(%r11), %r9
               	movzbq	(%r9), %r11
               	xorq	$0x5, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400268 <.text+0x48>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfeb9(%rip), %r11      # 0x410128
               	movq	(%r11), %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %r11
               	xorq	$0x1a, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4002a0 <.text+0x80>
               	movl	$0x2, %eax
               	retq
               	leaq	0xfe81(%rip), %r11      # 0x410128
               	addq	$0x8, %r11
               	movq	(%r11), %rax
               	movzbq	(%rax), %r11
               	xorq	$0x9, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4002d8 <.text+0xb8>
               	movl	$0x3, %eax
               	retq
               	leaq	0xfe49(%rip), %r11      # 0x410128
               	addq	$0x8, %r11
               	movq	(%r11), %rax
               	addq	$0x9, %rax
               	movzbq	(%rax), %r11
               	xorq	$0x4, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400317 <.text+0xf7>
               	movl	$0x4, %eax
               	retq
               	leaq	0xfe0a(%rip), %r11      # 0x410128
               	addq	$0x10, %r11
               	movq	(%r11), %rax
               	addq	$0x9, %rax
               	movzbq	(%rax), %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400356 <.text+0x136>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
