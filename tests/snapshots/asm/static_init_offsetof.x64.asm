
static_init_offsetof.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movzbq	(%r11), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40025e <.text+0x3e>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe6b(%rip), %r9       # 0x4100d0
               	addq	$0x1, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x4, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400297 <.text+0x77>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe32(%rip), %rax      # 0x4100d0
               	addq	$0x2, %rax
               	movzbq	(%rax), %r9
               	xorq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4002cc <.text+0xac>
               	movl	$0x3, %eax
               	retq
               	leaq	0xfdfd(%rip), %r9       # 0x4100d0
               	addq	$0x3, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x10, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400305 <.text+0xe5>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfdc4(%rip), %rax      # 0x4100d0
               	addq	$0x4, %rax
               	movzbq	(%rax), %r9
               	xorq	$0x12, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40033a <.text+0x11a>
               	movl	$0x5, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
