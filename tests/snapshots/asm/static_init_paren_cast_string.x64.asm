
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
               	movq	%r11, %r9
               	xorq	$0x5, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	je	0x40026b <.text+0x4b>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfeb6(%rip), %r9       # 0x410128
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x5, %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x1a, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x4002a8 <.text+0x88>
               	movl	$0x2, %eax
               	retq
               	leaq	0xfe79(%rip), %r9       # 0x410128
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x9, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x4002e5 <.text+0xc5>
               	movl	$0x3, %eax
               	retq
               	leaq	0xfe3c(%rip), %r9       # 0x410128
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movq	%r9, %rax
               	addq	$0x9, %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	xorq	$0x4, %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x400331 <.text+0x111>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfdf0(%rip), %rax      # 0x410128
               	movq	%rax, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x9, %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x400378 <.text+0x158>
               	movl	$0x5, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
